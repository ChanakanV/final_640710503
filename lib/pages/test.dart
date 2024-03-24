import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TodoItem {
  final String id;
  final String title;
  final String image;

  TodoItem({required this.id, required this.title, required this.image});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoItem> _todoItems = [];
  List<String> _webTypes = []; // ประกาศ List เพื่อเก็บประเภทเว็บ
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;

  @override
  void initState() {
    super.initState();
    _loadWebTypes();
  }

  // เมธอดสำหรับโหลดประเภทเว็บ
  Future<void> _loadWebTypes() async {
    try {
      List<String> webTypes =
          await fetchWebTypes(); // เรียกใช้ fetchWebTypes() เพื่อโหลดข้อมูล
      setState(() {
        _webTypes = webTypes; // กำหนดข้อมูลที่โหลดมาให้กับตัวแปร _webTypes
      });
    } catch (e) {
      // กรณีเกิดข้อผิดพลาดในการโหลดข้อมูล
      showOkDialog(context: context, title: "Error", message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // ทำให้ title อยู่ตรงกลาง
        backgroundColor: Color.fromARGB(
            255, 30, 55, 108), // ตั้งค่าสีพื้นหลังของ AppBar เป็นสีน้ำเงิน
        title: Text(
          'Webby Fondue',
          style: TextStyle(color: Colors.white), // เปลี่ยนสีข้อความเป็นขาว
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                '*ต้องกรอกข้อมูล',
                style: TextStyle(fontSize: 10.0),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'URL',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8.0), // ปรับ padding ของช่องข้อความ
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'รายละเอียด',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8.0), // ปรับ padding ของช่องข้อความ
              ),
            ),
            const SizedBox(height: 8.0),
            Center(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // จัดวางตำแหน่งชิดซ้าย
                children: [
                  Text(
                    'ระบุประเภทเว็บเลว*',
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSelected1 = !_isSelected1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.zero, // ลบ padding ภายในปุ่ม
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // เส้นขอบสีดำ
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        // รูปภาพจาก URL
                        Image.network(
                          'image/images/casino.jpg',
                          width: 60, // กำหนดขนาดของรูปภาพ
                          height: 70,
                          fit: BoxFit.cover, // ปรับขนาดรูปภาพให้พอดีกับพื้นที่
                        ),
                        SizedBox(width: 8.0), // ระยะห่างระหว่างรูปภาพกับข้อความ
                        Expanded(
                          child: Text(
                            'เว็บพนัน' +
                                "\n" +
                                "การพนัน แทงบอล และอื่นๆ", // แทนที่ชื่อเว็บด้วยข้อความที่เหมาะสม
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Checkbox(
                          value: _isSelected1,
                          onChanged: (newValue) {
                            setState(() {
                              _isSelected1 = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.0), // ระยะห่างระหว่างปุ่ม

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSelected2 = !_isSelected2;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.zero, // ลบ padding ภายในปุ่ม
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // เส้นขอบสีดำ
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        // รูปภาพจาก URL
                        Image.network(
                          'image/images/โจร.jpg',
                          width: 60, // กำหนดขนาดของรูปภาพ
                          height: 70,
                          fit: BoxFit.cover, // ปรับขนาดรูปภาพให้พอดีกับพื้นที่
                        ),
                        SizedBox(width: 8.0), // ระยะห่างระหว่างรูปภาพกับข้อความ
                        Expanded(
                          child: Text(
                            'เว็บปลอมแปลง ลอกเลียนแบบ' +
                                "\n" +
                                "หลอกให้กรอกข้อมูลส่วนตัว/รหัสผ่าน", // แทนที่ชื่อเว็บด้วยข้อความที่เหมาะสม
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Checkbox(
                          value: _isSelected2,
                          onChanged: (newValue) {
                            setState(() {
                              _isSelected2 = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.0),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSelected3 = !_isSelected3;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.zero, // ลบ padding ภายในปุ่ม
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // เส้นขอบสีดำ
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        // รูปภาพจาก URL
                        Image.network(
                          'image/images/ข่าว.jpg',
                          width: 60, // กำหนดขนาดของรูปภาพ
                          height: 70,
                          fit: BoxFit.cover, // ปรับขนาดรูปภาพให้พอดีกับพื้นที่
                        ),
                        SizedBox(width: 8.0), // ระยะห่างระหว่างรูปภาพกับข้อความ
                        Expanded(
                          child: Text(
                             'เว็บข่าวมั่ว' +
                            "\n" +
                            "Fake news, ข้อมูลที่ทำให้เข้าใจผิด", // แทนที่ชื่อเว็บด้วยข้อความที่เหมาะสม
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Checkbox(
                          value: _isSelected3,
                          onChanged: (newValue) {
                            setState(() {
                              _isSelected3 = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSelected4 = !_isSelected4;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.zero, // ลบ padding ภายในปุ่ม
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // เส้นขอบสีดำ
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        // รูปภาพจาก URL
                        Image.network(
                          'image/images/แชร์.jpg',
                          width: 60, // กำหนดขนาดของรูปภาพ
                          height: 70,
                          fit: BoxFit.cover, // ปรับขนาดรูปภาพให้พอดีกับพื้นที่
                        ),
                        SizedBox(width: 8.0), // ระยะห่างระหว่างรูปภาพกับข้อความ
                        Expanded(
                          child: Text(
                             'เว็บแชร์ลูกโซ่' + "\n" + "หลอกลงทุน", // แทนที่ชื่อเว็บด้วยข้อความที่เหมาะสม
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Checkbox(
                          value: _isSelected4,
                          onChanged: (newValue) {
                            setState(() {
                              _isSelected4 = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.zero,
                      backgroundColor: Color.fromARGB(255, 30, 55, 108)),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // เส้นขอบสีดำ
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: double.infinity, // ทำให้ปุ่มเต็มความกว้าง
                      height: 40,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0), // ปรับ padding ของตัวหนังสือในปุ่ม
                      child: Text(
                        'ส่งข้อมูล',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleApiPost() async {
    try {
      // เรียกใช้งาน API เพื่อสร้าง Todo ใหม่
      final data = await ApiCaller().post(
        "todos",
        params: {
          "userId": 1,
          "title": "Test Todo",
          "completed": true,
        },
      );
      Map<String, dynamic> map = jsonDecode(data);
      String text =
          'ส่งข้อมูลสำเร็จ\n\n - id: ${map['id']} \n - userId: ${map['userId']} \n - title: ${map['title']} \n - completed: ${map['completed']}';
      showOkDialog(context: context, title: "Success", message: text);
    } on Exception catch (e) {
      showOkDialog(context: context, title: "Error", message: e.toString());
    }
  }

  Future<void> _handleShowDialog() async {
    await showOkDialog(
      context: context,
      title: "This is a title",
      message: "This is a message",
    );
  }
}

class ApiCaller {
  ApiCaller();

  Future<String> get(String endpoint) async {
    // สำหรับเรียกใช้งาน API GET
    // สร้าง instance ของ ApiCaller
    ApiCaller ap = ApiCaller();
    // เรียกใช้งานเมธอด get และเก็บผลลัพธ์ไว้ในตัวแปร responseData
    String responseData = await ap.get("todos");
    Map<String, dynamic> params = {
      "userId": 1,
      "title": "ทดสอบ",
      "completed": false,
    };
    return ''; // ตัวอย่างการ return ข้อมูลที่ได้จาก API
  }

  Future<String> post(String endpoint,
      {required Map<String, dynamic> params}) async {
    // สำหรับเรียกใช้งาน API POST
    // สร้าง instance ของ ApiCaller
    ApiCaller ap = ApiCaller();
    // เรียกใช้งานเมธอด post และเก็บผลลัพธ์ไว้ในตัวแปร responseData
    String responseData = await ap.post("todos", params: params);
    return ''; // ตัวอย่างการ return ข้อมูลที่ได้จาก API
  }
}

Future<void> showOkDialog(
    {required BuildContext context,
    required String title,
    required String message}) async {
  // สร้าง Dialog แสดงข้อความและปุ่ม OK
}
Future<List<String>> fetchWebTypes() async {
  try {
    final response = await Dio().get(
      'https://cpsu-api-49b593d4e146.herokuapp.com/api/2_2566/final/web_types',
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load web types');
    }
  } catch (e) {
    throw Exception('Failed to load web types: $e');
  }
}
