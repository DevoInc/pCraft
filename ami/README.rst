AMI Library
===========

A Friendly library integrating an action language to create scenarios for Pcraft. 

```
git clone --recursive https://github.com/devoinc/pcraft/ami/
```

AMI is a language designed to describe actions taken for each step in an attack scenario and provide to the developer access to each action with variables in order to execute the right thing. Similar to how CSS works with HTML, AMI is not doing anything, but only provides one action at a time to be implemented.

This is a C library with C++ bindings generating Python bindings.

Your first AMI script
---------------------

AMI scripts have the .ami extension. This is the most simple script one can write:

```
ami_version 1

message "Hello, World!"

action MyFirstAction {
    $var = "some text"
    exec ThisAction
}
```

Which can be parsed in Python:

```
#!/usr/bin/python3
import pyami

ami = pyami.Ami()
ami.Parse("hello.ami")
actions = ami.GetActions()

print("We had %d actions" % len(actions))

for a in actions:
    print("New Action:")
    print("Name:%s" % a.Name())
    print("Exec:%s" % a.Exec())
    print("Variables:%s" % str(a.Variables()))

```

Which gives this when we run it:

```
$ python3 hello.py
Hello, World!
We had 1 actions
New Action:
Name:MyFirstAction
Exec:ThisAction
Variables:{'$var': 'some text'}

```

