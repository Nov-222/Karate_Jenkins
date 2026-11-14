package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class GatlingSimulation extends Simulation {

  val protocol = karateProtocol(
    "/public/v2/users/{userid}" -> Nil
  )

  // Escenario: ejecuta tu feature de Karate
  val testScenario = scenario("Prueba de carga con Karate GET")
    .exec(karateFeature("classpath:examples/users/Users.feature@Obtener_Usuarios"))

  // Inyección de usuarios
  setUp(
    testScenario.inject(
      rampUsers(1) during (1.seconds),
      constantUsersPerSec(1) during (2.seconds)
    ).protocols(protocol)
  )
}