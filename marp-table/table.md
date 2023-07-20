---
marp: true
paginate: true
theme: code
size: 16:9
title: marp-markdown
emoji: true
headingDivider: 1
---

# Simple

Title 1 | Title 2 | Title 3
--------|---------|---------
Text    | Entry   | longer entry i dont know

# Align


Title 1 | Title 2 | longer Title I dont know
-------:|:-------:|---------:
Text    | Entry   |  entry i dont know

# Latex table

https://isaurssaurav.github.io/mathjax-table-generator/

$$
\[
\begin{array}{|c|c|c|}
\hline
  \text{Set} & \text{Operation} & \text{Identity} \\ 
\hline
   \mathbb{Z} & + & 0 \\
\hline
   \mathbb{Q} & + & 0 \\
\hline
   \mathbb{R} & + & 0 \\ 
\hline
   \mathbb{Z} & \times & 1 \\
\hline
   \mathbb{Q} & \times & 1 \\
\hline
   \mathbb{R} & \times & 1 \\ 
\hline
\end{array}
\]
$$

# html table


<style scoped>
/* Reset table styling provided by theme */
table, tr, td, th {
  all: unset;

  /* Override contextual styling */
  border: 0 !important;
  background: transparent !important;
}
table { display: table; }
tr { display: table-row; }
td, th { display: table-cell; }

/* ...and layout freely :) */
table {
  width: 100%;
}
td {
  text-align: center;
  vertical-align: middle;
}
</style>

<table>
  <tr>
    <td>foo</td>
    <td><img src="https://fakeimg.pl/160x90/ccc/999/" /></td>
  </tr>
  <tr>
    <td><img src="https://fakeimg.pl/160x90/ccc/999/" /></td>
    <td>bar</td>
  </tr>
</table>

# Two columns

<style scoped>
.container{
    display: flex;
}
.col{
    flex: 1;
}
</style>

<div class="container">

<div class="col">
Column 1 Content
</div>

<div class="col">
Column 2 Content
</div>

</div>