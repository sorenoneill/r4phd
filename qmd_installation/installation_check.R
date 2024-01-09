# This script is intented to test whether the basic
# requirements for an R-installation is met, prior
# to taking part in the R4PHD courses.

### Operating system

sys_name <- Sys.info()[['sysname']]
sys_version <- Sys.info()[['release']]
sys_machine <- Sys.info()[['machine']]

if (sys_name %in% c("Linux", "MacOS", "Windows")) {
  print(paste0("[OK] Your operating system is ", sys_name, " (version ", sys_version,")"))
} else {
  print(paste0("[WARNING] Your operating system is reported as '", sys_name, "'. 'Linux', MacOS' or 'Windows' was expected."))
}

### CPU architecture

if (sys_machine %in% c("x86_64", "amd64", "arm64", "x86-64")) {
  print("[OK] You computer has a 64 bit CPU")
} else if (sys_machine %in% c("i386", "i586", "i686")) {
  print("[WARNING] You computer has an older 32 bit CPU")
} else {
  print(paste0("[WARNING] You computer is reported as ",sys_machine," ... not what was expected."))
}

### R version

r_version_major <- R.Version()[['major']]
r_version_string <- R.Version()[['version.string']]

if (r_version_major >= "4") {
  print(paste0("[OK] R installation is: ", r_version_string))
} else {
  print(paste0("[WARNING] An R version 4.x.x is recommended. You installation is ", r_version_string))
}

### RStudio version

all_installed_packages <- .packages(all.available = TRUE)

if (!"rstudioapi" %in% all_installed_packages | TRUE) {
  print(paste0("[WARNING] 'rstudioapi' (package) is NOT installed. Run: install.packages('rstudioapi') from console command line and then re-run script"))
  quit()
}

rstudio_type <- rstudioapi::versionInfo()$mode
rstudio_version <- rstudioapi::versionInfo()$version

if (rstudio_type == "desktop") {
  print("[OK] The RStudio installation is 'desktop'")
} else {
  print(paste0("[WARNING] The RStudio installation is '", rstudio_type,"'. Version 'desktop' is recommended!"))
}

if (rstudio_version > "2023") {
  print(paste0("[OK] The RStudio version is ",rstudio_version))
} else {
  print(paste0("[WARNING] The RStudio version is ",rstudio_version, ". Version 2023+ was expected."))
}


recommended_packages <- c("tidyverse", "here", "skimr", "gt", "gtExtras", "gtsummary", "patchwork", "naniar", "reprex", "ggstatsplot", "easystats", "vroom")

for (p in recommended_packages) {
  if (p %in% all_installed_packages) {
    print(paste0("[OK] '", p, "' (package) is installed."))
  } else {
    print(paste0("[WARNING] '", p, "' (package) is NOT installed."))
  }
}

