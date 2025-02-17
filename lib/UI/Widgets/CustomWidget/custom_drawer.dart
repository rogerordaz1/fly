import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../Business_logic/Provaiders/book_flight_provider.dart';
import '../../../Business_logic/Provaiders/forms_providers/status_provider.dart';
import '../../../Business_logic/Provaiders/login_provider.dart';
import '../../../Business_logic/Provaiders/news_provider.dart';
import '../../../Constants/contants.dart';
import 'custom_row_drawer.dart';
import '../SeparationWidget/separador.dart';
import 'package:provider/provider.dart';

import '../../../Business_logic/Provaiders/contact_provider.dart';
import '../widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final loginProvider = Provider.of<LoginProvider>(context);
    final userProvider = Provider.of<ContactProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
    final newsProvider = Provider.of<NewsProvider>(context);
    final bookProvider = Provider.of<BookFlightProvider>(context);
    return Drawer(
      child: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.only(
                top: constraints.biggest.height * 0.03,
                left: constraints.biggest.width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Scaffold.of(context).closeDrawer(),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('assets/fondo.png'),
                            radius: 20,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: constraints.biggest.width * 0.03,
                        ),
                        Column(
                          children: [
                            Text(
                              'Miranda Charter',
                              style: TextStyle(
                                  fontSize: constraints.biggest.height * 0.03),
                            ),
                          ],
                        )
                      ],
                    ),
                    loginProvider.email == ""
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: constraints.biggest.width * 0.12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/login');
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: constraints.biggest.height * 0.03,
                                  ),
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('Iniciar Sesión',
                                          style: TextStyle(
                                              fontSize:
                                                  constraints.biggest.height *
                                                      0.025))),
                                ],
                              ),
                            ),
                          )
                        : Text(
                            loginProvider.email,
                            style: TextStyle(
                                fontSize: constraints.biggest.height * 0.025),
                          ),
                  ],
                ),
                SizedBox(
                  height: constraints.biggest.height * 0.03,
                ),
                CustomRowDrawer(
                    onPressed: () async {
                      loadingSpinner(context);
                      try {
                        Future<bool> respuesta2 =
                            bookProvider.refillFieldBookFlights();
                        await newsProvider.getNewsList();

                        var respuesta = newsProvider.respuesta;

                        if (respuesta == true && await respuesta2 == true) {
                          Navigator.pop(context);

                          Navigator.of(context).pushNamed('/airlines');
                        } else {
                          Navigator.pop(context);

                          var snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Error!',
                              message: "A ocurrido algun error en la API",
                              contentType: ContentType.failure,
                            ),
                          );

                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } catch (error) {
                        Navigator.pop(context);
                        var snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Error!',
                            message: error.toString(),
                            contentType: ContentType.failure,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    icono: Icons.house_outlined,
                    texto: "Inicio",
                    tamnofuente: constraints.biggest.height * 0.025),
                const Separador(),
                CustomRowDrawer(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/search');
                      // Navigator.of(context).pushNamed('/login');
                    },
                    icono: Icons.library_books,
                    texto: "Reservar Vuelo",
                    tamnofuente: constraints.biggest.height * 0.025),
                const Separador(),
                CustomRowDrawer(
                    onPressed: () async {
                      loadingSpinner(context);
                      bool respuesta = await statusProvider
                          .getInfoStatus(loginProvider.loggedUser!.jwt);

                      if (respuesta == true) {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushNamed('/check_reservation_status');
                      } else {
                        Navigator.of(context).pop();
                        var snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Error!',
                            message: "Error al obtener datos",
                            contentType: ContentType.failure,
                          ),
                        );

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    icono: Icons.airplane_ticket_outlined,
                    texto: "Reservaciones",
                    tamnofuente: constraints.biggest.height * 0.025),
                const Separador(),
                CustomRowDrawer(
                    onPressed: () async {
                      if (loginProvider.loggedUser?.jwt != null) {
                        Navigator.of(context).pushNamed('/home');
                      } else {
                        loadingSpinner(context);
                        //comprobar si el token es valido si da error
                        bool respuesta = await loginProvider.loginMobileUser();
                        if (respuesta == true) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed('/home');
                        }
                      }
                      // Navigator.of(context).pushNamed('/login');
                    },
                    icono: Icons.connecting_airports_outlined,
                    texto: "Aerolínea",
                    tamnofuente: constraints.biggest.height * 0.025),
                const Separador(),
                CustomRowDrawer(
                    icono: Icons.contacts_outlined,
                    texto: "Contactos",
                    tamnofuente: constraints.biggest.height * 0.025,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      loadingSpinner(context);
                      bool respuesta = await userProvider
                          .getsContacts(loginProvider.loggedUser!.jwt);

                      if (respuesta == true) {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed('/contacts');
                      } else {
                        Navigator.pop(context);

                        Scaffold.of(context).closeDrawer();
                        var snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Error!',
                            message: userProvider.error,
                            contentType: ContentType.failure,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
                const Separador(),
                SizedBox(
                  height: constraints.biggest.height * 0.41,
                ),
                const Separador(),
                CustomRowDrawer(
                    icono: Icons.security_outlined,
                    texto: "Política de Privacidad",
                    tamnofuente: size.height * 0.023),
                const Separador(),
                CustomRowDrawer(
                    icono: Icons.contact_support_outlined,
                    texto: "Contactanos",
                    tamnofuente: size.height * 0.023),
              ],
            ),
          );
        }),
      ),
    );
  }
}
