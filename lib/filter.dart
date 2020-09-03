import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Filter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilterState();
  }
}

class FilterState extends State<Filter> {
  Future<SharedPreferences> prefs;
  //prefs.getInt("val")

  double _width;
  List<String> _categories = [
    "General",
    "Business",
    "Entertainment",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];
  List<bool> _categoriesSelection = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> _storedFormatCategory;
  int selectedItems = 0;

  @override
  void initState() {
    prefs = SharedPreferences.getInstance();
    prefs.then((sharedPref) {
      setState(() {
        _storedFormatCategory = sharedPref.getStringList("categories");
        if (_storedFormatCategory != null) {
          _storedFormatCategory
              .removeWhere((element) => element.contains(" false"));
          _storedFormatCategory =
              _storedFormatCategory.map((e) => e.split(" ")[0]).toList();
          for (var i = 0; i < _categories.length; i++) {
            if (_storedFormatCategory.contains(_categories[i])) {
              setState(() {
                _categoriesSelection[i] = true;
                selectedItems++;
              });
            }
          }
        }

        _storedFormatCategory = List<String>();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose your news category',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _categories.length,
                    itemBuilder: (BuildContext _context, int i) {
                      return Container(
                        height: 80,
                        child: Card(
                            child: Row(
                          children: [
                            Checkbox(
                                value: _categoriesSelection[i],
                                onChanged: (value) {
                                  setState(() {
                                    value ? selectedItems++ : selectedItems--;
                                    _categoriesSelection[i] =
                                        !_categoriesSelection[i];
                                  });
                                }),
                            Text(
                              _categories[i],
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        )),
                      );
                    }),
              ),
              Container(
                  height: 40,
                  width: _width * 0.7,
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: selectedItems == 0 ? Colors.grey : Colors.amber),
                  child: FlatButton(
                    onPressed: selectedItems == 0
                        ? null
                        : () {
                            // ACTIONS
                            for (var i = 0;
                                i < _categoriesSelection.length;
                                i++) {
                              _storedFormatCategory.add(_categories[i] +
                                  " " +
                                  _categoriesSelection[i].toString());
                            }
                            prefs.then((shared) => shared.setStringList(
                                "categories", _storedFormatCategory));
                            Navigator.of(context).pushReplacementNamed('/news');
                          },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        //fontFamily: 'Pacifico',
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
