.PHONY: all clean
IRIS_URL = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"

data/raw/iris.csv:
	python src/data/download.py $(IRIS_URL) $@

clean:
	rm -f data/raw/*.csv

all: data/raw/iris.csv

