Wrappers for web frameworks to ease usage with the FP Complete environment.
========

This package provides very simplistic wrappers to enable running code using the
Snap and Happstack web frameworks on the FP Complete environment. The only
modification to standard behavior is that the port number is read from the PORT
environment variable as opposed to being specified on either the command line
or in the code itself. If you're using Yesod, the function warpEnv is provided
in the Yesod module itself, which performs the same function.

For the most part, it should be sufficient to import the relevant module from
this package in place of the standard module, e.g. import
`Snap.Http.Server.Env` instead of `Snap.Http.Server`, or `Happstack.Server.Env`
instead of `Happstack.Server`.
