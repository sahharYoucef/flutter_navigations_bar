# flutter_navigations_bar

A new Flutter package for navigations bar.

## Getting Started

![Alt Text](https://media.giphy.com/media/VJYUtvzOarmG1BjcRW/giphy.gif)





# Bouncing Circle navigation bar

### properties : 

1.  final Function(int) onchanged : required value
2.  final Color iconColor : Default => Colors.white;
3.  final List<BottomNavigationBarItem> icons : required value;
4.  final Color barColor : Default => Colors.amber;
5.  final Color circleColor : Default => Colors.cyan;
6.  final BoxShadow boxShadow;
7.  final Gradient gradient;
8.  final double margin : Default => 0.0;
9.  final double height : Default : 70.0;

### Example : 

```dart
CustomBottomNavigationBar(
              height: 100,
              margin: 16.0,
              icons: <BarIcon>[
                BarIcon(
                    icon: Icon(Icons.access_alarm),
                    lable: "Alarm",
                    onPressed: () {}),
                BarIcon(
                    icon: Icon(Icons.cake), 
                    lable: "Cake", 
                    onPressed: () {}),
                BarIcon(
                    icon: Icon(Icons.account_circle),
                    lable: "Account",
                    onPressed: () {}),
                BarIcon(
                    icon: Icon(Icons.add_a_photo),
                    lable: "Camera",
                    onPressed: () {}),
              ],
              barColor: Colors.red,
              circleColor: Colors.orange,
              iconColor: Colors.black,
            ),
```

# Highlight navigation bar 

### properties : 

1. final double height : required value
2.  final List<IconButton> icons : required value
3.  final Duration duration : Default(Duration(milliseconds: 900))
4.  final Color backgroundColor : Default(Color(0xff2c362f))
5.  final Color unselectedIconColor : Default(Colors.grey)
6.  final Color selectedIconColor : Default(Colors.white)

### Example : 

```dart
 NavigationBar(
              height: 100,
              icons: [
                IconButton(icon: Icon(Icons.access_alarm), onPressed: (){}),
                IconButton(icon: Icon(Icons.accessibility_new), onPressed: (){}),
                IconButton(icon: Icon(Icons.add_call), onPressed: (){}),
                IconButton(icon: Icon(Icons.satellite), onPressed: (){}),
              ],
            ),
```