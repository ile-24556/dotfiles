#!/bin/bash

readonly STOW_DIR="stow"

ls "${STOW_DIR}" | xargs stow -v -d "${STOW_DIR}" -t "${HOME}" -R
