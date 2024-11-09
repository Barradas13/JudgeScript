# JudgeScript
A bash script that tests the inputs and outputs of competitive programming exercises, after the [OBI (Brazillian Informatics Olympiad)](https://olimpiada.ic.unicamp.br/) format.

You'll need bash installed in your machine to use it. Also, it only has support for C++ programs.

## Use
Put the tests folders, your program and this script in the same folder.

In the bash script, change the variable **nome** to the name of your program, and **max** to the number of test folders.

Then, open the terminal in the folder with the script, and run </br>
`bash judge.sh`

All answers your program gives will be stored in **./saidasminhas**, and all encountered differences between your answers and the correct outputs will be stored in **./diffs**. </br>
If by the end of the script, **diffs** is empty, than your program passed all tests! 

## License
*[GNU General Public License v3.0](./LICENSE)*
