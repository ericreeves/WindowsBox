

New-Item -ItemType Directory -Force -Path $HOME\.config\komorebi
Copy-Item -Path .\komorebi\*  -Destination $HOME\.config\komorebi\

New-Item -ItemType Directory -Force -Path $HOME\.glazewm
Copy-Item -Path .\glazewm\*  -Destination $HOME\.glazewm\

New-Item -ItemType Directory -Force -Path $HOME\.workspacer
Copy-Item -Path .\workspacer\*  -Destination $HOME\.workspacer\
