import 'package:flutter/material.dart';
//TODO make this prettier


class ticTacToe extends StatefulWidget {
  @override
  _ticTacToe createState() => _ticTacToe();
}

class _ticTacToe extends State<ticTacToe> {

  //matrix
  List<List> _matrix;

  //initialize size of matrix
  _ticTacToe(){
    _initMatrix();
  }

  _initMatrix(){
    // ignore: deprecated_member_use
    _matrix = List<List>(3);
    for(var i = 0; i < _matrix.length; i++){
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix.length; j++){
        _matrix[i][j] = " ";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   title: new Text('Tic Tac Toe'),
      // ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildELement(0, 0),
                  _buildELement(0, 1),
                  _buildELement(0, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildELement(1, 0),
                  _buildELement(1, 1),
                  _buildELement(1, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildELement(2, 0),
                  _buildELement(2, 1),
                  _buildELement(2, 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _lastChar = 'O';

  //build grid spot and also be given coordinates
  _buildELement(int i, int j) {
    return GestureDetector(
      onTap: (){
        //print("I am tapping the board");
        _changeMatrixField(i, j);
        _checkWinState(i, j);
        if (_checkDraw()){
          _showDialog("nobody");
        }
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Center(
          child: Text(
            _matrix[i][j],
            style: TextStyle(fontSize: 130.0),
          ),
        ),
      ),
    );
  }

  _changeMatrixField(int i, int j){
    setState(() {
      if (_matrix[i][j] == " ") {
        if (_lastChar == 'O') {
          _matrix[i][j] = 'X';
        } else {
          _matrix[i][j] = 'O';
        }
        _lastChar = _matrix[i][j];
      }
    });
  }

  _checkWinState(int x, int y){
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length-1;
    var player = _matrix[x][y];

    for (var i = 0; i < _matrix.length; i++){
      if (_matrix[x][i] == player)
        col++;
      if (_matrix[i][y] == player)
        row++;
      if (_matrix[i][i] == player)
        diag++;
      if (_matrix[i][n-i] == player)
        rdiag++;
    }
    if (row == n+1 || col == n+1 || diag == n+1 || rdiag == n+1){
      //print('$player won');
      _showDialog(player);
    }
  }

  _checkDraw(){
    var draw = true;
    _matrix.forEach((i) {
      i.forEach((j) {
        if (j == ' ')
          draw = false;
      });
    });
    return draw;
  }

  _showDialog(String Winner){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("GAME OVER"),
              content: Text('$Winner won'),
              actions: <Widget>[
                FlatButton(
                  child: Text("Reset Game"),
                  onPressed: (){
                    Navigator.of(context).pop();
                    setState(() {
                      _initMatrix();
                    });
                  },
                )
              ]
          );
        }
    );
  }


}
