#!/bin/bash
name=$(basename "${CLAUDE_PROJECT_DIR:-$PWD}")
say "${name}'s waiting"
