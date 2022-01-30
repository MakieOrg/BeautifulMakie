using ArchGDAL
using HDF5
dataset = ArchGDAL.read("./data/fuji.tif")
dataset_read = ArchGDAL.read(dataset)
topo = dataset_read[:, end:-1:1]

h5write("./data/fuji.h5", "fuji", topo)
