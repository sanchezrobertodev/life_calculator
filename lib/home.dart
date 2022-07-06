import 'package:flutter/material.dart';
import 'package:life_calculator/utils/colors.dart';
import 'package:life_calculator/utils/data.dart';
import 'package:life_calculator/widgets/app_bar.dart';
import 'package:life_calculator/widgets/button.dart';
import 'package:life_calculator/widgets/custom_text.dart';
import 'package:life_calculator/widgets/textfield.dart';
import 'package:life_calculator/widgets/visuals.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final DataProvider dataProvider = DataProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '💀 Life Calculator 💀',
      ).appBar(),
      backgroundColor: AppColors().background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
          future: dataProvider.setData(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return ColumnBody(
                dataProvider: dataProvider,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
            
          }
        ,)
      ),
    );
  }
}

class ColumnBody extends StatefulWidget {
  const ColumnBody({
    Key? key,
    required this.dataProvider
  }) : super(key: key);
  final DataProvider dataProvider;

  @override
  State<ColumnBody> createState() => _ColumnBodyState();
}

class _ColumnBodyState extends State<ColumnBody> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late String dropdownCountry;
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();
  final List<Widget> _widgets = [];
  final List<String> genders = ['Male', 'Female'];
  String cGender = 'Male';
  double totalTime = 0;



  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    dropdownCountry = widget.dataProvider.countries.first.value!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _calculateVisuals(){
    double years = widget.dataProvider.getExpectancy(dropdownCountry, 'Male');
    totalTime = widget.dataProvider.yearsToWeeks(years);
    
    setState(() {
      if(_widgets.isNotEmpty) {_widgets.clear();}
      for (var i = 0; i < totalTime; i++) {
        _widgets.add(
          AnimatedSize(
            duration: const Duration(seconds: 2),
            curve: Curves.bounceIn,
            child: dotLife()
          )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CustomText(
          text: 'Life Calculator',
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 20),
        const CustomText(
          text: 'Calculate your life expectancy and see how long you can live.',
          fontSize: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  hintText: 'Name(Optional)',
                  ).textField(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  controller: _ageController,
                  focusNode: _ageFocus,
                  hintText: 'Your Age',
                  keyboardType: TextInputType.number,
                  ).textField(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: cGender,
                  onChanged: (newValue) {
                    setState(() {
                      cGender = newValue!;
                    });
                  },
                  items: genders.map((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  hint: const CustomText(text: 'Country'),
                  value: dropdownCountry,
                  items: widget.dataProvider.countries,
                  onChanged: (value){
                    setState(() {
                      dropdownCountry = value!;
                    });
                  })
              ),
          ],),
        ),
        CustomButton(
          text: 'Calculate',
          onPressed: (){
            _calculateVisuals();
          })
          .elevatedButton(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Visualizaton(widgets: _widgets,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(
            text: totalTime == 0 ? '' 
            : '${totalTime.toStringAsFixed(2)} Weeks Left',
            fontSize: 20,
          ),
          )
      ],
    );
  }

  // Future<Container> visualContainer(BuildContext context) async {
  //   return Container(
  //         // height: 400,
  //         width: MediaQuery.of(context).size.width,
  //         padding: const EdgeInsets.all(7.5),
  //         alignment: Alignment.topLeft,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: AppColors().chartBack,
  //         ),
  //         child: Visualizaton(
  //           widgets: _widgets,),
  //       );
  // }
}

class Visualizaton extends StatelessWidget {
  const Visualizaton({
    Key? key,
    required this.widgets,
  }) : super(key: key);
  final List<Widget> widgets;

  static List<Widget> circles(){
    List<Widget> circles = [];
    for (var i = 0; i < 3000; i++) {
      circles.add(
        AnimatedSize(
          duration: const Duration(seconds: 2),
          child: dotUsed())
      );
    }
    return circles;
  }
  Future<Widget> widget(BuildContext context) async{
    return Container(
      width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(7.5),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors().chartBack,
          ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        direction: Axis.horizontal,
        runSpacing: 2.5,
        spacing: 2.5,
        children: widgets.isEmpty ? 
          circles()
          : widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget(context),
      builder: (context, AsyncSnapshot snapshot) { 
        if(snapshot.connectionState == ConnectionState.done){
          return snapshot.data!;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}