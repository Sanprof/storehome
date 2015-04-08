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

        static UserSessionState()
        {
            using (var store = new Entities())
            {
                store.UserSessions.RemoveRange(store.UserSessions.ToList());
                store.SaveChanges();
            }
            Task<Task>.Factory.StartNew(GCClear).Unwrap();
        }

        public static string AddNew(int userID, bool rememberme)
        {
            string result = Token.NewToken().ToString().ToLower();
            while (userSessions.Keys.Contains(result))
            {
                result = Token.NewToken().ToString().ToLower();
            }
            userSessions.Add(result, new UserSession() { UserID = userID, TokenExpired = (rememberme ? DateTimeOffset.UtcNow.AddMonths(1) : DateTimeOffset.UtcNow.AddMinutes(sessionExpired)), RememberMe = rememberme });
            return result;
        }

        public static void Update(object key)
        {
            if (userSessions.ContainsKey(Convert.ToString(key)))
                userSessions[Convert.ToString(key)].TokenExpired = userSessions[Convert.ToString(key)].RememberMe ? DateTimeOffset.UtcNow.AddMonths(1) : DateTimeOffset.UtcNow.AddMinutes(sessionExpired);
        }

        private static async Task GCClear()
        {
            DateTimeOffset lastCheck = DateTimeOffset.UtcNow;
            while (true)
            {
                if (lastCheck.AddSeconds(30) <= DateTimeOffset.UtcNow)
                {
                    using (var store = new Entities())
                    {
                        foreach (var item in userSessions.Where(kvp => kvp.Value.TokenExpired <= DateTimeOffset.UtcNow).ToList())
                        {
                            var uSession = store
                                .UserSessions
                                .Where(us => us.Token.CompareTo(item.Key) == 0)
                                .FirstOrDefault();
                            if (uSession != null)
                            {
                                store.UserSessions.Remove(uSession);
                            }
                        }
                        store.SaveChanges();
                    }
                    userSessions = userSessions.Where(kvp => kvp.Value.TokenExpired > DateTimeOffset.UtcNow).ToDictionary(x => x.Key, x => x.Value);
                    lastCheck = DateTimeOffset.UtcNow;
                }
                await Task.Delay(30000);
            }
        }

        public static bool TokenIsValid(object key)
        {
            if (userSessions.ContainsKey(Convert.ToString(key)) &&
                userSessions[Convert.ToString(key)].TokenExpired > DateTimeOffset.UtcNow)
            {
                Update(key);
                return true;
            }

            return false;
        }

        public static int? UserID(object key)
        {
            return userSessions.ContainsKey(Convert.ToString(key)) ? (int?)userSessions[Convert.ToString(key)].UserID : null;
        }

        public static void RemoveToken(int userID)
        {
            var sessionUser = userSessions.Select(us => new { us.Value.UserID, us.Key }).Where(s => s.UserID.Equals(userID));
            foreach (var item in sessionUser)
                RemoveToken(item.Key);
        }

        public static void RemoveToken(object token)
        {
            userSessions.Remove(Convert.ToString(token));
        }

        public static void InitializeSession()
        {
        }
    }

    public class UserSession
    {
        public int UserID { get; set; }
        public DateTimeOffset TokenExpired { get; set; }
        public bool RememberMe { get; set; }
    }
}
