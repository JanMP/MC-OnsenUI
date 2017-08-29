import News from "/imports/client/ui/common/News.vue"
import ModuleList from "/imports/client/ui/web/ModuleList.vue"
import Login from "/imports/client/ui/web/Login.vue"
import Problem from "/imports/client/ui/web/Problem.vue"
import UserStatistics from "/imports/client/ui/web/UserStatistics.vue"
export default routes = [
  path : '/'
  name : 'news'
  component : News
,
  path : '/login'
  name : 'login'
  component : Login
,
  path : '/aufgaben'
  name : 'aufgaben'
  component : ModuleList
,
  path : '/aufgaben/:moduleKey'
  name : 'problem'
  component : Problem
,
  path : '/statistik'
  name : 'statistik'
  component : UserStatistics
]
