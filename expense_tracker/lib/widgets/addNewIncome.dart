import 'package:flutter/material.dart';
import 'package:expense_tracker/models/income.dart';

class AddNewIncome extends StatefulWidget {
  final void Function (IncomeModel expence)onAddIncome;
  const AddNewIncome({super.key, required this.onAddIncome});

  @override
  State<AddNewIncome> createState() => _AddNewIncomeState();
}

class _AddNewIncomeState extends State<AddNewIncome> {
  final _titleController =TextEditingController();
  final _amountController =TextEditingController();

  Category _selectedCategory =Category.Wages;

  //date variables

  final DateTime initialDate=DateTime.now();
  final DateTime firstDate=DateTime(DateTime.now().year-1, DateTime.now().month,DateTime.now().day);
  final DateTime lastDate=DateTime(DateTime.now().year+1, DateTime.now().month,DateTime.now().day);

  DateTime _selectedDate =DateTime.now();

  //date picker
  Future <void> _openDateModel() async{
    try{
      //show the date model and store the selected date
     final pickedDate= await
      showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
      setState(() {
        _selectedDate=pickedDate!;
      });
      

    }catch(err){
      print(err.toString());
    }
  }

  //handle submit
  void _handleFormSubmit(){
    //convert the amount to a double
    final userAmount=double.parse(_amountController.text.trim());
    if(_titleController.text.trim().isEmpty || userAmount<=0){
      showDialog(
        context:context,
        builder: (context){
        return AlertDialog(
            title: const Text("Enter the valid data"),
            content: const Text(
              "Please make sure to enter valid data in all fields before proceeding."),
              actions:[
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, 
                child: const Text("Close"),
                ),
              ],
            );
          },
       );
    }
    else{
      IncomeModel newExpence= IncomeModel(amount: userAmount, date: _selectedDate,
       title: _titleController.text.trim(), category: _selectedCategory);
      widget.onAddIncome(newExpence);
      Navigator.pop(context);
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleController ,
            decoration: const InputDecoration(
              hintText: "Add a new expence title",
              label:Text("Title"),
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: [
             Expanded(
               child: TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  helperText: "Enter the amount",
                  label:Text("Amount"),
                ),
                keyboardType: TextInputType.number,
               ),
             ),
    
             Expanded(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text(formattedDate.format(_selectedDate)),
              IconButton(onPressed: _openDateModel,
              icon: const Icon(Icons.date_range_outlined),
              ),
            ],
           ),
          ),
         ],
        ),
        
        Row(
          children: [
            DropdownButton(
              value: _selectedCategory,
              items:Category.values
              .map(
                (category)=>DropdownMenuItem(
                  value:category,
                  child: Text(category.name),
                ),
                )
                .toList(),
            onChanged: (value){
              setState(() {
                _selectedCategory=value!;
              });
              _selectedCategory=value!;
            },
              ),
              Expanded(child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                //close button
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, 
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                ),
                child: const Text("Close"),
                ),
                const SizedBox(width: 10,),
    
                ElevatedButton(onPressed: _handleFormSubmit, 
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.greenAccent),
                ),
                child: const Text("Save"),
                ),
              ],))
          ],
        )
        ],
      ),
    );
  }
}