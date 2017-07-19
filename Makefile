.PHONY: all clean test
IRIS_URL = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"

data/raw/iris.csv:
	python src/data/download.py $(IRIS_URL) $@

clean:
	rm -f data/raw/*.csv
	rm -f data/processed/*.pickle
	rm -f data/processed/*.xlsx
	rm -f reports/figures/*.png
	rm -f models/*.model

all: reports/figures/exploratory.png models/random_forest.model

reports/figures/exploratory.png: data/processed/processed.pickle
	python src/visualization/exploratory.py $< $@

data/processed/processed.pickle: data/raw/iris.csv
	python src/data/preprocess.py $< $@ --excel data/processed/processed.xlsx

test: all
	pytest src

models/random_forest.model: data/processed/processed.pickle
	python src/models/train_model.py $< $@
