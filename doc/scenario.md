Writing a Scenario
==================

The Scenario file is a YAML file, first and foremost, it must comply with the YAML Language.

The Scenario file must start with:

```
start: <ACTION_NAME>
```

The Action Name is the entry point, it must call a generating plugin only (one that does not requires anything to start with).

Then, for each action call there are various options, at least:
- The Plugin name to call
- The next step

For example, to create a DNS Connection, one must write:
```
Create_a_new_connection:
  _plugin: DNSConnection
  _next: done
```

Each option starting with the _ character means it is part of the engine. Anything which does not start with _ means it is part
of the plugin.

The obvious question here is "But where IS my domain I do a DNS Connection to?", well, in this specific case, it has been
passed as a paramater coming from the previous plugin, as the "domain" variable.

