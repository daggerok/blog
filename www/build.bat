@echo off

call npm run dependencies
call npm run deploy
call npm win-test
