```
     ___           ___           ___                         ___           ___
    /  /\         /  /\         /__/|                       /  /\         /  /\
   /  /:/_       /  /:/        |  |:|                      /  /::\       /  /:/_
  /  /:/ /\     /  /:/         |  |:|      ___     ___    /  /:/\:\     /  /:/ /\
 /  /:/ /::\   /  /:/  ___   __|  |:|     /__/\   /  /\  /  /:/  \:\   /  /:/_/::\
/__/:/ /:/\:\ /__/:/  /  /\ /__/\_|:|____ \  \:\ /  /:/ /__/:/ \__\:\ /__/:/__\/\:\
 \  \:\/:/~/:/ \  \:\ /  /:/ \  \:\/:::::/  \  \:\  /:/  \  \:\ /  /:/ \  \:\ /~~/:/
  \  \::/ /:/   \  \:\  /:/   \  \::/~~~~    \  \:\/:/    \  \:\  /:/   \  \:\  /:/
   \__\/ /:/     \  \:\/:/     \  \:\         \  \::/      \  \:\/:/     \  \:\/:/
     /__/:/       \  \::/       \  \:\         \__\/        \  \::/       \  \::/
     \__\/         \__\/         \__\/                       \__\/         \__\/
```

# SCKLog Client
Quickstart remote debugging code. Helps when you are unable to attach your XCode console to a process.

[SCKLog server](https://github.com/mikezucc/SCKLogServer)

Client breakdown:
1. POST to `/start` with the appropriate session stamp to start a new log file with that <sessionstamp>-log.txt
2. POST to `/log` and watch them print on `/watch` web page. They will also show in the text file browsable through static root `http://localhost:3003/`.

## observe
`/` => shows directory through Ecstatic static file server

`/watch`, active session web page

## api
path `/start` 

    body:{"session":<string>}
    method:`POST`
     

path `/log`

    body:{"payload":<string>}
    method:`POST`
