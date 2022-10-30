class Figure {
  String name;
  int numberOfSteps;
  
  Figure({required this.name, required this.numberOfSteps});
  
  factory Figure.fromJson(Map<String, dynamic> json) {
    return Figure(
      name: json['name'],
      numberOfSteps: json['numberOfSteps'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'numberOfSteps': numberOfSteps,
    };
}