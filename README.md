# cmd-mods
A simple guide to install and configure software that will help regain cmd its purpose by giving it Linux terminal like abilities.

# rough notes (TBC)

## Core Tools
1. [Cmder](http://cmder.net/) ([Clink](https://mridgers.github.io/clink/) + [GitForWindows](https://gitforwindows.org/) Variant)
1. [Hyper](https://github.com/zeit/hyper) (Optional)

## Configuration
1. Install Cmder in a top-level folder like `C:\Cmder`.
1. Replace `C:\Cmder\vendor\init.bat` with the custom `init.bat` file provided in this repo. This removes items which causes infinite loops when trying to add Cmder to cmd start-up.
1. Open Regedit and navigate to ``Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor``
1. Add **String Value** with *key: ``AutoRun``* and *value: ``"%CMDER_ROOT%\vendor\init.bat"``* with quotes. Make sure this is of ``REG_SZ`` type.
1. Try opening cmd and if all goes well you should see a λ symbol in your console window!
1. Optional: Install Hyper or use Cmder's terminal.

## Results
<img src="https://raw.githubusercontent.com/hsed/cmd-mods/master/results/test1.png" height="480">
