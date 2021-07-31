part of 'helpers.dart';

void calculandoOrder( BuildContext context) {

  if ( Platform.isAndroid ) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Espere por favor'),
        content: Text('Solicitando Conductor'),
      ),
    );

  } else {

    showCupertinoDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: Text('Espere por favor'),
        content: CupertinoActivityIndicator(),
      ),
    );

  }


}







