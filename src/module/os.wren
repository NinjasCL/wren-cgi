class Platform {
  foreign static homedir
  foreign static isPosix
  foreign static name

  static isWindows { name == "Windows" }

  static home {homedir}

  // End of line separator character
  static eol {isWindows ? "\r\n" : "\n"}

  // Directory separator character
  static dirsep {isWindows ? "\\" : "/"}
  static directorySeparator {dirsep}

  // PATH separator character
  static pathsep {isWindows ? ";" : ":"}
  static pathSeparator {pathsep}
}

class Process {
  // TODO: This will need to be smarter when wren supports CLI options.
  static arguments { allArguments[2..-1] }

  foreign static allArguments
  foreign static cwd
  foreign static pid
  foreign static ppid
  foreign static exePath
  foreign static version

  static path {exePath}
}
