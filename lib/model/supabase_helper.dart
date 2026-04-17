import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Stream<List<T>> getDataStream<T>({
  required String table,
  required List<String> ids,
  required T Function(Map<String, dynamic> map) fromJson
}
    ){
  final supabase = Supabase.instance.client;
  var stream = supabase.from(table).stream(primaryKey: ids);
  return stream.map(
  (event) => event.map((map) => fromJson(map),).toList(),
  );
}

Future<Map<int, T>> getMapData<T>({
  required String table,
  required T Function(Map<String, dynamic> map) fromJson,
  required int Function(T t) getID
}) async{
  final data = await supabase.from(table).select();
  var iterable = data.map((e) => fromJson(e),);
  return Map.fromIterable(
    iterable,
    key: (element) => getID(element),
    value: (element) => element,
  );
}

listenDataChange<T>(Map<int, T> maps,{Function()? updateUI,
  required String channel,
  required String table,
  required T Function(Map<String, dynamic> map) fromJson,
  required int Function(T t) getId,
  String scheme = "public",

}){
  supabase
      .channel(channel)
      .onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: scheme,
      table: table,
      callback: (payload) {
        //print('Change received: ${payload.toString()}');
        switch(payload.eventType){
          case PostgresChangeEvent.insert:
          case PostgresChangeEvent.update:{
            T f = fromJson(payload.newRecord);
            maps[getId(f)] = f;
            updateUI?.call();
            break;
          }
          case PostgresChangeEvent.delete:{
            maps.remove(payload.oldRecord["id"]);
            updateUI?.call();
            break;
          }
          default:{}
        }
      })
      .subscribe();
}