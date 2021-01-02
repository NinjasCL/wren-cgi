import "env" for Env

System.print(Env.all is Map) // expect: true
System.print(Env.all.keys.count > 0) // expect: true
