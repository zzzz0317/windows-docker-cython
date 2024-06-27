FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022
ENV LANG=C.UTF-8

SHELL ["cmd", "/S", "/C"]

#================================#
# Download and build chocolatey
RUN powershell "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

#================================#
# Adds Visual Studio + recommend tools
RUN powershell "Invoke-WebRequest -Outfile buildtools.exe -Uri https://aka.ms/vs/17/release/vs_BuildTools.exe"
RUN powershell ".\buildtools.exe --quiet --wait --norestart --nocache --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"

#================================#
# Installing python
RUN powershell "Invoke-WebRequest -Outfile python-3.12.4-amd64.exe -Uri https://www.python.org/ftp/python/3.12.4/python-3.12.4-amd64.exe"
RUN cmd /c start /wait python-3.12.4-amd64.exe /passive InstallAllUsers=1 TargetDir=C:\Python PrependPath=1 Shortcuts=0 Include_doc=0

#================================#
ENTRYPOINT [ "cmd" ]
