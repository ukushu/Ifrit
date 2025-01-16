v.2.0.4 ~Not released yet~
* Added ability to choose sorting strategy for search in array of objects
* Changed default sorting strategy to "minimum score". For FuseSwift it was "average score". 

v.2.0.3
* score -> diffScore - more intuitive prop name
* updated documentation

v.2.0.2

* Documentation improvements
* Ability to set QoS for fuse search
* Improved sync search speed a little bit
* Fixed crash caused of binary operation arithmetic overflow

v.2.0.1

* Documentation improvements
* Removed garbage from the repo
* Minor improvements


v.2.0.0

* Fuseable -> Searchable
* Ability to search by exact property instead of standart "Fuseable's'" "properties" property. This will give you ability to implement different search logic for single type of objects. Use case sample: if user search in ukrainian language - it searches title in ukrainian language titles. In case of english - in englishe titles.
* Fixed doctumentation for Fuse from mistakes. Now documentation's code is covered by tests to be sure documentation samples is actual.
* Minor syntax improvements


v1.1.1


v1.1.0
