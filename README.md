My personal NVIM configuration and set up

Hello everyone.

This repo is made just to track the progress of the **from O to God mode** creating and configuring from scratch
my own `vim/nvim` set up.

This allows me to keep tracked the changes I introduce over the time, see how my personal configuration evolves over the time and share it with anyone instested while I am able to make some sort of tutorial while I am writing it.

Also, this allows me to have a reference point whenever I got into a new computer or set up, so I can quickly just `git clone` this repository and start to work inmmediatly.

References (TODO)

The primagean videos
The guy on medium

DIFFERENT OS

I mostly do my coding personal job on `Linux` and `Windows` (like 70% - 30%) and my professional paid job the other way around, `Windows` and `Linux` (like 85% - 15%), and I use `Linux` mostly though `WSL`.

So you won't find any interesting here about `Mac`

For `Unix` users, vim already comes by default on most of the modern distros. And `nvim` is an easy to get one.
But `Windows` is a different kind of thing. You'll need to do some job to get your `nvim` working fine or it, so I'll let you [here](TODO link to the medium guide) a nice guide of how to get and install it on `Windows`.

REMAPS and **leader** key

For convenience, in my set up I like to have the [leader key](TODO link to docs) mapped to the `spacebar` key.
The spacebar is extremely fast and confortable, since I am able to reach it with both hands quickly and without having to make any extrange movements with any of my fingers.

All the remaps configured for this setup are in the [remap.lua](./lua/therustifyer/remap.lua)

The most notorious one for me are:

- `:<leader>pv`: Goes back to `Netrw` from the source origin `:so`

