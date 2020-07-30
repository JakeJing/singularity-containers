using Distances

dis = euclidean(rand(3), rand(3))
print(dis)

ID = parse(Int64, ENV["SLURM_ARRAY_TASK_ID"])
print(ID)

# print(typeof(ID)) # convert task ID into integer


