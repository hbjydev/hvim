;; fennel-ls: macro-file

(fn car [xs] (. xs 1))

(lambda expr->str [expr] `(macrodebug ,expr nil))

(fn str?    [x] (= (type x) "string"))
(fn tbl?    [x] (= (type x) "table"))
(fn fn?     [x] (= (type x) "function"))
(fn nil?    [x] (= nil x))
(fn quoted? [x] (and (list? x) (= x `quote (car x))))

(lambda quoted->fn [expr]
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (. expr 2)]
    `(fn [] ,non-quoted)))

(lambda quoted->str [expr]
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (. expr 2)]
    (.. "'" (view non-quoted))))

(fn ->str [x] (tostring x))
(fn ->bool [x] (if x true false))

(fn begins-with? [chars str] (->bool (str:match (.. "^" chars))))

(fn expand-exprs [exprs]
  (if (> (length exprs) 1)
      `(do
        ,(unpack exprs))
      (car exprs)))

(tset _G :hvim/pack {})
(tset _G :hvim/modules {})

(fn djb2 [str]
  "Implementation of the hash function djb2.
  This implementation is extracted from https://theartincode.stanis.me/008-djb2/.
  
  Arguments:
  * `str`: the string to hash
  Returns:
  * `str` hashed with djb2
  Example:
  ```fennel
  (assert (= (djb2 \"hello\") \"5d41402abc4b2a76b9719d911017c592\"))
  ```"
  (let [bytes (icollect [char (str:gmatch ".")]
                (string.byte char))
        hash (accumulate [hash 5381 _ byte (ipairs bytes)]
               (+ byte hash (bit.lshift hash 5)))]
    (bit.tohex hash)))

(lambda gensym-checksum [x ?options]
  "Generates a new symbol from the checksum of the object passed as a parameter
  after it is casted into an string using the `view` function.
  You can also pass a prefix or a suffix into the options optional table.
  This function depends on the djb2 hash function."
  (let [options (or ?options {})
        prefix (or options.prefix "")
        suffix (or options.suffix "")]
    (sym (.. prefix (djb2 (view x)) suffix))))

(lambda map! [[modes] lhs rhs ?options]
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (sym? rhs) (fn? rhs) (quoted? rhs))
                  "expected string, symbol, function or quoted expression for rhs"
                  rhs)
  (assert-compile (or (nil? ?options) (table? ?options))
                  "expected table for options" ?options)
  (let [modes (icollect [char (string.gmatch (->str modes) ".")]
                char)
        options (or ?options {})
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? rhs) (quoted->str rhs)
                                (str? rhs) rhs
                                (view rhs))))
                    options)
        rhs (if (quoted? rhs) (quoted->fn rhs) rhs)]
    `(vim.keymap.set ,modes ,lhs ,rhs ,options)))

(lambda let-with-scope! [[scope] name value]
  (assert-compile (or (str? scope) (sym? scope))
                  "expected string or symbol for scope" scope)
  (assert-compile (or (= :b (->str scope)) (= :w (->str scope))
                      (= :t (->str scope)) (= :g (->str scope)))
                  "expected scope to be either b, w, t or g" scope)
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)
        scope (->str scope)]
    `(tset ,(match scope
              :b `vim.b
              :w `vim.w
              :t `vim.t
              :g `vim.g) ,name ,value)))

(lambda let-global! [name value]
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)]
    `(tset vim.g ,name ,value)))

(lambda let! [...]
  "Set a vim variable using the vim.<scope>.name API.
  Accepts the following arguments:
  [scope] -> optional. Can be either [g], [w], [t] or [b]. It's either a symbol
             or a string surrounded by square brackets.
  name -> either a symbol or a string.
  value -> anything.
  Example of use:
  ```fennel
  (let! hello :world)
  (let! [w] hello :world)
  ```
  That compiles to:
  ```fennel
  (tset vim.g :hello :world)
  (tset vim.w :hello :world)
  ```"
  (match [...]
    [[scope] name value] (let-with-scope! [scope] name value)
    [name value] (let-global! name value)
    _ (error "expected let! to have at least two arguments: name value")))

(lambda set! [name ?value]
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
		  (not (begins-with? :no name))
		  ?value)

	value (if (quoted? value)
		  (quoted->fn value)
		  value)

	name (if (and (nil? ?value) (begins-with? :no name))
		 (name:match "^no(.+)$")
		 name)

	exprs (if (fn? value) [`(tset _G
				      ,(->str (gensym-checksum value
					                      {:prefix "__"}))
				      ,value)] [])
	exprs (doto exprs
		(table.insert (match (name:sub -1)
				"+" `(: (. vim.opt ,(name:sub 1 -2)) :append
					,value)
				"-" `(: (. vim.opt ,(name:sub 1 -2)) :remove
					,value)
				"^" `(: (. vim.opt ,(name:sub 1 -2)) :prepend
					,value)
				_ `(tset vim.opt ,name ,value))))]
    (expand-exprs exprs)))

(lambda pack [identifier ?options]
  "Processes a package specification into the correct format for Packer.

  Example:
  ```fennel
  (pack :hvim-engineering/oxocarbon.nvim {:opt true})
  ```"

  ;; ensure the arguments are of the correct types
  (assert-compile (str? identifier) "expected identifier to be a string" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected ?options to be a table" ?options))

  ;; get the options (or an empty table) and process it
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (match k
                    ;; if this declares a module, load its config
                    :hvim-module (values :config
                                         (string.format "require(\"modules.%s.config\")" v))

                    ;; return the options
                    _ (values k v)))]

    ;; set idx 1 to the package name
    (doto options
      (tset 1 identifier))))

(lambda use! [identifier ?options]
  (assert-compile (str? identifier) "expected identifier to be a string" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected ?options to be a table" ?options))
  (table.insert _G.hvim/pack (pack identifier ?options)))

(lambda hvim! [...]
  (var moduletag nil)
  (var registry {})

  (fn register-module [name]
    (if (str? name)
      (set moduletag name) ;; tag
      (if (sym? name)
        (let [name (->str name)
              include-path (.. :fnl.modules. moduletag "." name)
              config-path (.. :modules. moduletag "." name :.config)]
          (tset registry name
            {:include-paths [include-path] :config-paths [config-path]}))
	(let [modulename (->str (car name))
	      include-path (.. :fnl.modules. moduletag "." modulename)
	      config-path (.. :modules. moduletag "." modulename :.config)
	      [_ & flags] name]
	  (var includes [include-path])
	  (var configs [config-path])
	  (each [_ v (ipairs flags)]
	    (let [flagmodule (.. modulename "." (->str v))
		  flag-include-path (.. include-path "." (->str v))
		  flag-config-path (.. :modules. moduletag "." flagmodule :config)]
	      (table.insert includes flag-include-path)
	      (table.insert configs flag-config-path)
	      (tset registry flagmodule {})))
	  (tset registry modulename
	        {:include-paths includes :config-paths configs})))))

  (fn register-modules [...]
    (each [_ mod (ipairs [...])]
      (register-module mod))
    registry)

  (let [modules (register-modules ...)]
    (tset _G :hvim/modules modules)))

(lambda hvim-module-p! [name ?config]
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
	module-exists (not= nil (. _G.hvim/modules name))]
    (if (nil? ?config)
	(if module-exists
	    `true
	    `false)
	(let [config (or ?config)]
	  (when module-exists
	    `,config)))))

(lambda hvim-init-modules! []
  (fn init-module [module-name module-def]
    (icollect [_ include-path (ipairs (or module-def.include-paths []))]
      `(include ,include-path)))
  
  (fn init-modules [registry]
    (icollect [module-name module-def (pairs registry)]
      (init-module module-name module-def)))

  (let [inits (init-modules _G.hvim/modules)]
    (expand-exprs inits)))

(lambda hvim-compile-modules! []
  (fn compile-module [module-name module-decl]
    (icollect [_ config-path (ipairs (or module-decl.config-paths []))]
      `,(pcall require config-path)))

  (fn compile-modules [registry]
    (icollect [module-name module-def (pairs registry)]
      (compile-module module-name module-def)))

  (let [source (compile-modules _G.hvim/modules)]
    (expand-exprs [(unpack source)])))

(lambda hvim-module! [name]
  "By default modules should be loaded through use-package!. Of course, not every
  modules needs a package. Sometimes we just want to load `config.fnl`. In this 
  case, we can hack onto packer.nvim, give it a fake package, and ask it to load a 
  config file.
  Example of use:
  ```fennel
  (hvim-module! tools.tree-sitter)
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        hash (djb2 name)]
    (table.insert _G.hvim/pack (pack (.. :hvim. hash) {:hvim-module name}))))

(lambda packadd! [package]
  (assert-compile (sym? package) "expected symbol for package" package)
  (let [package (->str package)]
    `(vim.api.nvim_cmd {:cmd :packadd :args [,package]} {})))

(lambda unpack! []
  (let [packs (icollect [_ v (ipairs _G.hvim/pack)]
		`(use ,v))
	use-sym (sym :use)]
    `((. (require :packer) :startup) (fn [,use-sym]
				       ,(unpack (icollect [_ v (ipairs packs)]
						  v))))))

(lambda colorscheme! [cs]
  (assert-compile (sym? cs) "expected symbol for cs" cs)
  (let [cs (->str cs)]
    `(vim.api.nvim_cmd {:cmd :colorscheme :args [,cs]} {})))

{;; stdlib-ish
 : str?
 : tbl?
 : ->str
 : djb2

 ;; packaging
 : pack
 : use!
 : unpack!

 ;; vim
 : set!
 : let!
 : map!
 : packadd!
 : colorscheme!

 ;; hvim
 : hvim!
 : hvim-module!
 : hvim-module-p!
 : hvim-compile-modules!
 : hvim-init-modules!}
