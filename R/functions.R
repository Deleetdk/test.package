# inner original ----------------------------------------------------------
inner_func1 = function(function_name) {
  #print envirs
  print_envir(environment(), "current ", recursive = T)
  print_envir(parent.frame(), "parent.frame ", recursive = T)

  match.fun(function_name)("hello")
}


inner_func2 = function(function_name) {
  #print envirs
  print_envir(environment(), "current ", recursive = T)
  print_envir(parent.frame(), "parent.frame ", recursive = T)

  #try to get object in current envir
  #if it isnt there, try parent.frame
  if (exists(function_name)) {
    warning(sprintf("%s exists", function_name))
    func = get(function_name)
  } else {
    warning(sprintf("%s does not exist", function_name))
    func = get(function_name, envir = parent.frame(n = 2))
  }

  func("hello")
}

inner_func2b = function(function_name) {
  #print envirs
  print_envir(environment(), "current ", recursive = T)
  print_envir(parent.frame(), "parent.frame ", recursive = T)

  #try to get object in current envir
  #if it isnt there, try parent.frame
  if (exists(function_name)) {
    warning(sprintf("%s exists", function_name))
    func = get(function_name)
  } else {
    warning(sprintf("%s does not exist", function_name))
    func = get(function_name, envir = parent.frame(n = 1))
  }

  func("hello")
}


inner_func3 = function(function_name) {
  #print envirs
  print_envir(environment(), "current ", recursive = T)
  print_envir(parent.frame(), "parent.frame ", recursive = T)

  #try to get object in current envir
  #if it isnt there, try parent.frame
  if (exists(function_name)) {
    warning(sprintf("%s exists", function_name))
    func = get(function_name)
  } else {
    warning(sprintf("%s does not exist", function_name))
    func = dynGet(function_name)
  }

  func("hello")
}



# outer ----------------------------------------------------------
#but with printing

outer_func1 = function(function_name) {
  #print envirs
  print_envir(environment(), "current ", recursive = T)
  print_envir(parent.frame(), "parent.frame ", recursive = T)
  print_envir(environment(inner_func1), "defining/enclosing ", recursive = T)

  #failing call
  inner_func1(function_name)
}



outer_func2 = function(function_name) {
  #print envirs
  print_envir(environment(), "current ", recursive = T)
  print_envir(parent.frame(), "parent.frame ", recursive = T)
  print_envir(environment(inner_func2), "defining/enclosing ", recursive = T)

  inner_func2(function_name)
}



outer_func3 = function(function_name) {
  #print envirs
  print_envir(environment(), "current ", recursive = T)
  print_envir(parent.frame(), "parent.frame ", recursive = T)
  print_envir(environment(inner_func3), "defining/enclosing ", recursive = T)

  inner_func3(function_name)
}


# environment print helper ------------------------------------------------------

print_envir = function(x, prefix = "", recursive = F, list_objects = T, max_objects = 10, use_names = T, no_attr = T, skip_beyond_global = T) {
  # browser()
  #use names
  if (use_names) {
    env_name_attr = attr(x, "name")
    if (is.null(env_name_attr)) {
      env_name_attr = ""
    } else {
      env_name_attr = sprintf(" (%s)", env_name_attr)
    }
  } else {
    env_name_attr = ""
  }

  #strip attributes?
  if (no_attr) {
    attributes(x) = NULL
  }

  #get name
  env_name = {capture.output(print(x))}

  #get parent env name
  # parent_env_name = {capture.output(print(parent.env(x)))}

  #objects
  if (list_objects) {
    env_objects = names(x)

    #limit
    env_objects = na.omit(env_objects[1:max_objects])

    #explicit none
    if (length(env_objects) == 0) {
      env_objects = "(none)"
    }
  } else {
    env_objects = "(not requested)"
  }


  #issue print as warning so they come thru testthat console
  warning(sprintf("%senvironment `%s`%s with objects: %s",
                  prefix,
                  env_name,
                  env_name_attr,
                  str_c(env_objects, collapse = ", ")
                  ), call. = F)

  #recursive?
  if (recursive) {
    #stop when parent is empty envir
    if (!identical(parent.env(x), emptyenv())) {
      #skip on top of global?
      if (!identical(x, globalenv())) {
        print_envir(parent.env(x), recursive = T, list_objects = list_objects, max_objects = max_objects, use_names = use_names, prefix = prefix, no_attr = no_attr)
      }
    }
  }

  invisible(NULL)
}


