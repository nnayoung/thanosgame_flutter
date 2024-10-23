import 'package:flutter/material.dart';

void main() {
  runApp(ThanosApp());
}

// StatelessWidget을 상속 받습니다.
class ThanosApp extends StatefulWidget {
  @override
  State<ThanosApp> createState() => _ThanosAppState();
}

class _ThanosAppState extends State<ThanosApp> {
  bool _showThanos = false;

  // _names 변수를 만들어줍니다.
  List<String> _names = [
    "김지연",
    "신하경",
    "박영서",
    "김서현",
    "김정섭",
    "이성찬",
    "민희원",
    "장민서",
    "전예린",
    "진선명",
    "이창윤",
    "정은정",
    "송정민",
    "이가현",
    "이예진",
    "김현태",
    "이승현",
    "김주원",
    "정연우",
    "김민성",
    "정다진",
    "이지연",
    "배기옥",
    "신찬희"
  ];

  // build 메소드를 구현합니다. ThanosApp에서 보여질 위젯들을 return에 넣어줍니다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("타노스 게임"),
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                GridView(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  shrinkWrap: false, // 기본적으로 false이므로 스크롤 가능
                  physics: AlwaysScrollableScrollPhysics(), // 항상 스크롤 가능하게
                  children: [
                    for (var name in _names)
                      NameCard(
                          name: name,
                          onDelete: () {
                            _names.remove(name);
                          }),
                  ],
                ),
              ],
            ),
            if (_showThanos)
              Center(
                child: Image.asset("assets/thanos_snap.gif"),
              )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          hoverColor: Colors.indigo,
          child: Image.asset(
            "assets/finger_snap.png",
            width: 40,
          ),
          onPressed: () async {
            setState(() {
              _showThanos = true;
            });
            await Future.delayed(Duration(milliseconds: 3500));
            
            setState(() {
              _showThanos = false;
            });
            
            setState(() {
              _names.shuffle(); // _names 뒤섞기
              final count = (_names.length / 2).toInt(); // _names의 길이의 절반
              _names = _names.take(count).toList(); // _names의 길이의 절반만큼만 남겨두기
            });
          },
        ),
      ),
    );
  }
}

class NameCard extends StatelessWidget {
  final String name;
  final VoidCallback onDelete;

  const NameCard({super.key, required this.name, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min, // 최소 크기 설정
        children: [
          Center(
            child: Text(name),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.grey,
            onPressed: onDelete,
          ),
        ],
      ),
    ));
  }
}

class LikeButton extends StatefulWidget {
  // 생성자: 위젯을 만들 때 호출됩니다.
  LikeButton({super.key});

  // State를 연결합니다. State에 모든 역할을 위임.
  @override
  LikeButtonState createState() => LikeButtonState();
}

class LikeButtonState extends State<LikeButton> {
  // 좋아요 상태를 나타내는 변수입니다.
  bool _isLiked = false;

  // 화면에 그릴 UI를 정의합니다.
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite, // 하트 모양 아이콘입니다.
        color: _isLiked ? Colors.red : Colors.grey, // 좋아요 여부에 따라 색상이 바뀝니다.
      ),
      onPressed: () {
        // setState를 통해 상태가 변했음을 알려줍니다.
        setState(() {
          _isLiked = !_isLiked; // 좋아요 상태를 업데이트 합니다.
        });
      },
    );
  }
}
