// Kotlin
// File: `app/src/main/java/com/example/compose/rally/RallyDestinations.kt`

package com.example.compose.rally

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AttachMoney
import androidx.compose.material.icons.filled.Money
import androidx.compose.material.icons.filled.MoneyOff
import androidx.compose.material.icons.filled.PieChart
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.vector.ImageVector
import com.example.compose.rally.ui.accounts.AccountsScreen
import com.example.compose.rally.ui.accounts.SingleAccountScreen
import com.example.compose.rally.ui.bills.BillsScreen
import com.example.compose.rally.ui.overview.OverviewScreen
import androidx.navigation.NavDeepLink
import androidx.navigation.NavType
import androidx.navigation.NamedNavArgument
import androidx.navigation.navArgument
import androidx.navigation.navDeepLink

interface RallyDestination {
    val icon: ImageVector
    val route: String
    val screen: @Composable () -> Unit
}

object Overview : RallyDestination {
    override val icon = Icons.Filled.PieChart
    override val route = "overview"
    override val screen: @Composable () -> Unit = { OverviewScreen() }
}

object Accounts : RallyDestination {
    override val icon = Icons.Filled.AttachMoney
    override val route = "accounts"
    override val screen: @Composable () -> Unit = { AccountsScreen() }
}

object Bills : RallyDestination {
    override val icon = Icons.Filled.MoneyOff
    override val route = "bills"
    override val screen: @Composable () -> Unit = { BillsScreen() }
}

object SingleAccount : RallyDestination {
    override val icon = Icons.Filled.Money
    override val route = "single_account"
    override val screen: @Composable () -> Unit = { SingleAccountScreen() }

    const val ACCOUNT_TYPE_ARG = "account_type"
    val routeWithArgs: String = "$route/{$ACCOUNT_TYPE_ARG}"
    val arguments: List<NamedNavArgument> = listOf(
        navArgument(ACCOUNT_TYPE_ARG) { type = NavType.StringType }
    )
    val deepLinks: List<NavDeepLink> = listOf(
        navDeepLink { uriPattern = "rally://single_account/{$ACCOUNT_TYPE_ARG}" }
    )
}

val rallyTabRowScreens = listOf(Overview, Accounts, Bills)