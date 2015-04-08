using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace StoreHouse.Common
{
    public static class PasswordGenerator
    {
        private readonly static Dictionary<int, char[]> spb = new Dictionary<int, char[]>()
        {
            { 1, "ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray()},
            { 2, "abcdefghijklmnopqrstuvwxyz".ToCharArray()},
            { 3, "123456789".ToCharArray()},
            { 4, "!@#$%^&*()|/?><".ToCharArray()}
        };
        private readonly static char[] upperAlpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray();
        private readonly static char[] lowerAlpha = "abcdefghijklmnopqrstuvwxyz".ToCharArray();
        private readonly static char[] numbers = "123456789".ToCharArray();
        private readonly static char[] symbols = "!@#$%^&*()|/?><".ToCharArray();

        public static string GetPassword(int length)
        {
            string pass = GetPass(length);
            while (!PassCorrect(pass))
                pass = GetPass(length);
            return pass;
        }

        private static string GetPass(int length)
        {
            Random rndMass = new Random(DateTimeOffset.Now.Millisecond);
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < length; i++)
            {
                int ch = rndMass.Next(-2, 5);
                while (!spb.ContainsKey(ch))
                    ch = rndMass.Next(-2, 6);
                int index = rndMass.Next(0, spb[ch].Length - 1);
                sb.Append(spb[ch][index]);
            }
            return sb.ToString();
        }

        private static bool PassCorrect(string pass)
        {
            int[] count = { 1, 2, 3, 4 };
            var arr = pass.ToCharArray();
            for (int i = 0; i < arr.Length; i++)
                for (int k = 1; k < 5; k++)
                    if (spb[k].Contains(arr[i]) && count.Contains(k))
                    {
                        count = count.Where(c => c != k).ToArray();
                        break;
                    }
            return count.Length == 0;
        }

        public static string GetPasswordSHA1(string password, int salt)
        {
            SHA1 sha1 = SHA1.Create();
            string str = salt + password;
            byte[] bytes = Encoding.UTF8.GetBytes(str);
            var hash = sha1.ComputeHash(bytes);
            StringBuilder sb = new StringBuilder();
            foreach (byte b in hash)
                sb.Append(b.ToString("X2"));
            return sb.ToString();
        }

        public static string GetPasswordSHA1(int length, int salt)
        {
            string password = GetPassword(length);
            SHA1 sha1 = SHA1.Create();
            string str = salt + password;
            byte[] bytes = Encoding.UTF8.GetBytes(str);
            var hash = sha1.ComputeHash(bytes);
            StringBuilder sb = new StringBuilder();
            foreach (byte b in hash)
                sb.Append(b.ToString("X2"));
            return sb.ToString();
        }
    }
}
