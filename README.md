# R-Shiny app for Dynamic Visualisation of the Iris Dataset

This is a dynamic application that allows you to visualise the iris dataset and change different parameters.

## Installation
To run the application, follow the following commands:

```terminal
git clone https://github.com/sohitmiglani/iris-scatter
cd iris-scatter
chmod 777 app.R
docker build -t iris-scatter .
docker run -it -p 8080:8080 iris-scatter
```

## Details

1. The application has been packaged inside Docker with a Microconda environment for an easier and streamlined installation of all the required R packages. Conda also allows for an easier documentation of the dependencies inside a separate file and keeps the Dockerfile separate.
2. The application uses two main R packages - 'shiny' for the main application and 'dplyr' for filtering the iris dataset.
