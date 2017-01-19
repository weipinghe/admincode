HBase Scanner Filter Examples
=================================

## References:
* [Original](https://gist.github.com/stelcheck/3979381)
* [HBase REST Filter (SingleColumnValueFilter)](http://stackoverflow.com/questions/9302097/hbase-rest-filter-singlecolumnvaluefilter)
* [HBase Intra-row scanning](http://stackoverflow.com/questions/13119369/hbase-intra-row-scanning)
* [HBase Book / Chapter on Client Filter](http://hbase.apache.org/book/client.filter.html)

### [ColumnPrefixFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/ColumnPrefixFilter.html)
```
{
  "type": "ColumnPrefixFilter",
  "value": "cHJlZml4"
}
```

### [ColumnRangeFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/ColumnRangeFilter.html)
```
{
  "type": "ColumnRangeFilter",
  "minColumn": "Zmx1ZmZ5",
  "minColumnInclusive": true,
  "maxColumn": "Zmx1ZmZ6",
  "maxColumnInclusive": false
}
```

### [ColumnPaginationFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/ColumnPaginationFilter.html)

Could not generate an example, but I guess it should be pretty simple to test if it works just by intuitively plugging variables a certain way...

### [DependentColumnFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/DependentColumnFilter.html)

null

### [FamilyFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/FamilyFilter.html)
```
{
  "type": "FamilyFilter",
  "op": "EQUAL",
  "comparator": {
    "type": "BinaryComparator",
    "value": "dGVzdHJvdw\u003d\u003d"
  }
}
```

### [FilterList with RowFilter and ColumnRangeFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/FilterList.html)
```
{
  "type": "FilterList",
  "op": "MUST_PASS_ALL",
  "filters": [
    {
      "type": "RowFilter",
      "op": "EQUAL",
      "comparator": {
        "type": "BinaryComparator",
        "value": "dGVzdHJvdw\u003d\u003d"
      }
    },
    {
      "type": "ColumnRangeFilter",
      "minColumn": "Zmx1ZmZ5",
      "minColumnInclusive": true,
      "maxColumn": "Zmx1ZmZ6",
      "maxColumnInclusive": false
    }
  ]
}
```

### [FirstKeyOnlyFilter (Can be used for more efficiently perform row count operation)](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/FirstKeyOnlyFilter.html)
```
{
  "type": "FirstKeyOnlyFilter"
}
```

### [InclusiveStopFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/InclusiveStopFilter.html)
```
{
  "type": "InclusiveStopFilter",
  "value": "cm93a2V5"
}
```

### [MultipleColumnPrefixFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/MultipleColumnPrefixFilter.html)
```
{
  "type": "MultipleColumnPrefixFilter",
  "prefixes": [
    "YWxwaGE\u003d",
    "YnJhdm8\u003d",
    "Y2hhcmxpZQ\u003d\u003d"
  ]
}
```

### [PageFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/PageFilter.html)
```
{
  "type": "PageFilter",
  "value": "10"
}
```

### [PrefixFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/PrefixFilter.html)
```
{
  "type": "PrefixFilter",
  "value": "cm93cHJlZml4"
}
```

### [QualifierFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/QualifierFilter.html)
```
{
  "type": "QualifierFilter",
  "op": "GREATER",
  "comparator": {
    "type": "BinaryComparator",
    "value": "cXVhbGlmaWVycHJlZml4"
  }
}
```

### [RowFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/RowFilter.html)
```
{
  "type": "RowFilter",
  "op": "EQUAL",
  "comparator": {
    "type": "BinaryComparator",
    "value": "dGVzdHJvdw\u003d\u003d"
  }
}
```

### [SingleColumnValueFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/SingleColumnValueFilter.html)
```
{
  "type": "SingleColumnValueFilter",
  "op": "EQUAL",
  "family": "ZmFtaWx5",
  "qualifier": "Y29sMQ\u003d\u003d",
  "latestVersion": true,
  "comparator": {
    "type": "BinaryComparator",
    "value": "MQ\u003d\u003d"
  }
}
```

### [TimestampsFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/TimestampsFilter.html)
```
{
  "type": "TimestampsFilter",
  "timestamps": [
    "1351586939"
  ]
}
```