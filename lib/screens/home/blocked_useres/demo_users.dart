class BlockedUser{
  String name;
  String email;
  String address;
  BlockedUser(this.name,this.email,this.address);

   static List<BlockedUser> blockedUsers=[
    BlockedUser('Omar Muhammad Ali', 'demomail12@gmail.com', '4 elharam st, cairo'),
    BlockedUser('Ahmed Amin Saber', 'maildemo@gmail.com', '124 Elmokatem st, cairo'),
    BlockedUser('Ahmed EzzEldin', 'ahmen12@gmail.com', '17 sobhi st, haram, giza'),
    BlockedUser('Al-shimaa hassan Ebrahim', 'warda421@gmail.com', '32 elshazly st, alexandria'),
  ];
}