Contents of `./data/` Directory
=========
Since files in this directory are not staged/committed, it's tough to communicate with collaborators what the files should look like on their computers.  Try to keep this list updated.

##### Files in `./data/unshared/raw/`

- `./data/unshared/raw/ALSA-Wave1.Final.sav`  
- `./data/unshared/raw/LBSL-Panel2-Wave1.Final.sav`  
- `./data/unshared/raw/SATSA-Q3.Final.sav`   
- `./data/unshared/raw/SHARE-Israel-Wave1.Final.sav`  
- `./data/unshared/raw/TILDA-Wave1.Final.sav`    

##### Files in `./data/unshared/derived/`

- `./data/unshared/derived/dto.rds` - the data transfer object (dto) of the project,  list object containing names, paths, dataframes, and metadata of the candidate studies

##### Files in `./data/shared/raw/`  
- [`./data/shared/meta-data-map.csv`](https://github.com/IALSA/ialsa-2016-groningen/blob/master/data/shared/meta-data-map.csv) - contains classification of the variables observed in the raw data. Changes introduced by manual edits. Interact with a [dynamic table]() based on its current content. 

##### Files in `./data/shared/derived/`   
- `./data/shared/derived/meta-raw-alsa.csv` - raw variable names and labels 
- `./data/shared/derived/meta-raw-lbsl.csv`  - raw variable names and labels 
- `./data/shared/derived/meta-raw-satsa.csv` - raw variable names and labels 
- `./data/shared/derived/meta-raw-share.csv` - raw variable names and labels 
- `./data/shared/derived/meta-raw-tilda.csv` - raw variable names and labels 
- [`./data/shared/derived/meta-raw-live.csv`](https://github.com/IALSA/ialsa-2016-groningen/blob/master/data/shared/derived/meta-raw-live.csv) - raw variable names and labels, combined. Refreshed every time `Ellis Islad` is executed.
