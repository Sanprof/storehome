using StoreHouse.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace StoreHouse.Common
{
    public static class UserSessionState
    {
        private static uint sessionExpired = Convert.ToUInt32(System.Web.Configuration.WebConfigurationManager.AppSettings["apiSessionExpired"]);

        private static Dictionary<string, UserSession> userSessions = new Dictionary<string, UserSession>();

        public static void InitializeSession()
        {
            //restore session
            using (var slic = new Entities())
            {
                foreach (var userSesion in slic.UserSessions.Where(us => us.Expired > DateTimeOffset.UtcNow))
                    lock (userSessions)
                    {
                        userSessions.Add(userSesion.Token, new UserSession() { UserID = userSesion.WorkerID, TokenExpired = DateTime.SpecifyKind(userSesion.Expired, DateTimeKind.Utc), RememberMe = userSesion.RememberMe });
                    }
            }
            Task<Task>.Factory.StartNew(GCClear).Unwrap();
        }

        public static string AddNew(int userID, bool rememberme)
        {
            string result = Token.NewToken().ToString().ToLower();
            while (userSessions.Keys.Contains(result))
                result = Token.NewToken().ToString().ToLower();
            DateTimeOffset expired = (rememberme ? DateTimeOffset.UtcNow.AddMonths(1) : DateTimeOffset.UtcNow.AddMinutes(sessionExpired));
            lock (userSessions)
            {
                userSessions.Add(result, new UserSession() { UserID = userID, TokenExpired = expired, RememberMe = rememberme });
            }
            using (var slic = new Entities())
            {
                slic.UserSessions.Add(new StoreHouse.Models.UserSession()
                {
                    WorkerID = userID,
                    Token = result,
                    RememberMe = rememberme,
                    Expired = expired.DateTime,
                    CreatedDate = DateTimeOffset.UtcNow.DateTime
                });
                slic.SaveChanges();
            }
            //SLICLog.Info(String.Format("Session created '{0}', Expired = {1}, Now is = {2}, token = '{3}'", sessionExpired, userSessions[Convert.ToString(result)].TokenExpired, DateTimeOffset.UtcNow, result));
            return result;
        }

        public static void Update(object key)
        {
            if (userSessions.ContainsKey(Convert.ToString(key)))
                userSessions[Convert.ToString(key)].TokenExpired = userSessions[Convert.ToString(key)].RememberMe ? DateTimeOffset.UtcNow.AddMonths(1) : DateTimeOffset.UtcNow.AddMinutes(sessionExpired);
            //else
            //SLICLog.Info(String.Format("User session with token = '{0}' not found", key));
        }

        private static async Task GCClear()
        {
            int checkPeriod = 30000;//30 second
            DateTimeOffset lastCheck = DateTimeOffset.UtcNow.AddMilliseconds(-checkPeriod);
            while (true)
            {
                if (lastCheck.AddMilliseconds(checkPeriod) <= DateTimeOffset.UtcNow)
                {
                    using (var slic = new Entities())
                    {
                        slic.DeleteExpiredSessions(DateTimeOffset.UtcNow.DateTime);
                        lock (userSessions)
                        {
                            userSessions = userSessions.Where(kvp => kvp.Value.TokenExpired > DateTimeOffset.UtcNow).ToDictionary(x => x.Key, x => x.Value);
                            //update expired
                            foreach (var item in userSessions)
                            {
                                var dbsession = slic
                                    .UserSessions
                                    //.AsEnumerable()
                                    .FirstOrDefault(us => us.Token.Equals(item.Key) && us.Expired < item.Value.TokenExpired.DateTime);
                                if (dbsession != null)
                                    dbsession.Expired = item.Value.TokenExpired.DateTime;
                            }
                        }
                        slic.SaveChanges();
                    }
                    lastCheck = DateTimeOffset.UtcNow;
                }
                await Task.Delay(checkPeriod);
            }
        }

        public static bool TokenIsValid(object key)
        {
            if (userSessions.ContainsKey(Convert.ToString(key)))
            {
                if (userSessions[Convert.ToString(key)].TokenExpired > DateTimeOffset.UtcNow)
                {
                    Update(key);
                    return true;
                }
                //SLICLog.Info(String.Format("User token is not valid, Expired = {0}, Now is = {1}, token = '{2}'", (DateTimeOffset?)userSessions[Convert.ToString(key)].TokenExpired, DateTimeOffset.UtcNow, key));
            }
            //else
            //SLICLog.Info(String.Format("User session with token = '{0}' not found", key));

            return false;
        }

        public static int? UserID(object key)
        {
            return userSessions.ContainsKey(Convert.ToString(key)) ? userSessions[Convert.ToString(key)].UserID : (int?)null;
        }

        public static void RemoveByUserID(int userID)
        {
            lock (userSessions)
            {
                //List<string> sessionUsers = null;
                var sessionUsers = userSessions.Select(us => new { us.Value.UserID, us.Key }).Where(s => s.UserID.Equals(userID)).Select(us => us.Key).ToList();
                foreach (var item in sessionUsers)
                    userSessions.Remove(item);
            }
            using (var slic = new Entities())
            {
                slic.DeleteUserSessionsByUserID(userID);
            }
            //SLICLog.Info(String.Format("User session was deleted by UserID = '{0}'", userID));
        }

        public static void RemoveToken(object token)
        {
            lock (userSessions)
            {
                userSessions.Remove(Convert.ToString(token));
            }
            using (var slic = new Entities())
            {
                slic.DeleteUserSessionsByToken(Convert.ToString(token));
            }
            //SLICLog.Info(String.Format("User session was deleted by Token = '{0}'", token));
        }
    }

    public class UserSession
    {
        public int UserID { get; set; }
        public DateTimeOffset TokenExpired { get; set; }
        public bool RememberMe { get; set; }
    }
}
