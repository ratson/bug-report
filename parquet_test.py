from pathlib import Path

import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq


def test_read_write_dataset(tmp_path):
    df = pd.DataFrame({
        'one': [-1, 0, 2.5],
        'two': ['foo', 'bar', 'baz'],
        'three': [True, False, True]
    }, index=list('abc'))
    table = pa.Table.from_pandas(df)
    assert len(table) == 3

    pq.write_to_dataset(table, root_path=tmp_path,
                        partition_cols=['one', 'two'])

    table2 = pq.read_table(tmp_path)
    assert len(table2) == len(table)

    pq.write_to_dataset(table2, root_path=tmp_path,
                        partition_cols=['one', 'two'])

    table3 = pq.read_table(tmp_path)
    assert len(table3) == len(table)
