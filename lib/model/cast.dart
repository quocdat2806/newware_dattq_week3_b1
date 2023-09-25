class Cast{
   String ?name ;
   String ?nickName;
   String ?image;
  Cast(this.name, this.nickName, this.image);

  @override
  String toString() {
    return 'Cast{name: $name, nickName: $nickName, image: $image}';
  }
}