import "env" for Env

System.print(Env.get("") == "") // expect: true
System.print(Env.get(null) == "") // expect: true
System.print(Env.get("USER") != "") // expect: true
