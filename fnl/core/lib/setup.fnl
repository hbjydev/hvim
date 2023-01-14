(local {: deep-merge} (require :core.lib.tables))
(local {: userconfigs} (require :core.shared))

(lambda setup [name ?config]
  (let [config (or ?config)]
    (local {: setup} (require name))
    (setup (deep-merge (?. userconfigs name) config))))

{: setup}
