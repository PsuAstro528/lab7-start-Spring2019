# Astro 528 Lab 7

Before starting this lab, make sure you've successfully gotten setup to use git, Jupyter, Julia.
The first lab contained detailed instructions for using the Jupyter notebook server.  

Remember, that you need follow the link provided via a course announcement to create your own private copy of this lab's repository on GitHub.com.   See the
[help on the course website](https://psuastro528.github.io/lessons/how-to-use-aci/) for instructions on cloning, commiting, pushing and submiting your work

You may wish to submit the PBS jobs first, so that your jobs can sit in the queue while you work through the notebooks.

## Exercise 1:  GPU Computing I: Getting Started & Linear Algebra
#### Goals:  
- Run GPU code on ICS-ACI 
- Accelerate linear algebra computations with GPU 
- Recognize what problem sizes and likely to result in acceleration with a GPU for linear algebra
From the ICS-ACI Jupyter notebook server, work through ex1.ipynb.
You'll also want to run it as a PBS job using one of the CyberLAMP GPU nodes.  
Review the results in the markdown file (and figures) created by the PBS job and use them to inform your responces.

## Exercise 2:  GPU Computing II: Broadcasting, Fusion, Reductions
#### Goals:  
- Perform custom scientific computations using high-level GPU interface
- Improve performance by reducing kernel launches via broadcasting and GPU kernel fusion
- Improve performance by reducing memory transfers via GPU reductions
- Recognize what types of problems and problem sizes are likely to result in acceleration with a GPU  when using a high-level programming interface
From the ICS-ACI Jupyter notebook server, work through ex1.ipynb.
You'll also want to run it as a PBS job using one of the CyberLAMP GPU nodes.  
Review the results in the markdown file (and figures) created by the PBS job and use them to inform your responces.

## Exercise 3:  GPU Computing III: Low-level GPU Programming
#### Goals:  
- Write a GPU kernel
- Improve performance through reduced memory usage
- Recognize when a custom kernel is likely improve GPU performance 
From the ICS-ACI Jupyter notebook server, work through ex3.ipynb.
You'll also want to run it as a PBS job using one of the CyberLAMP GPU nodes.  
Review the results in the markdown file (and figures) created by the PBS job and use them to inform your responces.


Remember to commit often, push your repository to GitHub and create a pull request as if you wanted to merge your work (presumably in your master branch) into the original branch (which contains the starter code). 

