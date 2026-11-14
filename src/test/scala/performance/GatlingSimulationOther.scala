package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class GatlingSimulationOther extends Simulation {

  val protocol = karateProtocol(
    "/public/v2/users/{userid}" -> Nil
  )

  // Escenario: ejecuta tu feature de Karate
  val testScenario = scenario("Prueba de carga con Karate Delete")
  .exec(karateFeature("classpath:examples/users/Users.feature@Usuario"))


  // Inyección de usuarios
  setUp(
    testScenario.inject(
      rampUsers(1) during (1.seconds),
      constantUsersPerSec(1) during (2.seconds)
    ).protocols(protocol)
  ).assertions(
    // 1. SLA Global: Tiempo de respuesta promedio máximo
    global.responseTime.mean.lte(1000), // El tiempo promedio de respuesta DEBE ser Menor o Igual a 1000 ms (1s)
    
    // 2. SLA Global: Porcentaje de errores máximo
    global.successfulRequests.percent.gte(99), // El porcentaje de solicitudes exitosas DEBE ser Mayor o Igual al 99%
    
    // 3. SLA por Escenario Específico (Opcional, pero más granular)
    details("DELETE /public/v2/users/{userid}").responseTime.max.lte(2000) // El tiempo maximo de respuesta del escenario no debe exceder 1000 ms
  )
}