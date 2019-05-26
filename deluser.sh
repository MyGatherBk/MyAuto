#!/bin/bash
# Script delete user SSH
# Created by pirakit khawpleum

read -p "Delete User : " Nama

userdel -r $Nama
