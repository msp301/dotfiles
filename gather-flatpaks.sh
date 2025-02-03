#!/bin/sh

flatpak list --columns=origin,application,arch,branch --app > flatpaks

