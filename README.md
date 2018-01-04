# Run the image and example vignette:
To run this container image, start it with:

```
docker run -d -p 8787:8787  sneumann/embo2018 
```

Then point your browser at http://localhost:8787/
and use credentials rstudio/rstudio
as mentioned in the documentation 
of the base image: https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image

# Re-build this image

```
docker build -t sneumann/embo2018 .
```