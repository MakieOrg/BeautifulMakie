@def prepath = "BeautifulMakie"
<!--
Add here global page variables to use throughout your website.
-->
+++
author = "Lazaro Alonso"
mintoclevel = 2

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = true
website_title = "BeautifulMakie"
website_descr = "Gallery"
website_url   = "https://lazarusa.github.io/BeautifulMakie/"
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}
\newcommand{\prettyshow}[1]{@@code-output \output{#1} @@}
