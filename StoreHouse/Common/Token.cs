using System;
using System.Text;

namespace StoreHouse.Common
{
    public struct Token
    {
        public static readonly string Empty = "000000000000000000000000";
        private string token;

        public Token(int A, int B, int C)
            : this()
        {
            byte[] a = BitConverter.GetBytes(A);
            byte[] b = BitConverter.GetBytes(B);
            byte[] c = BitConverter.GetBytes(C);
            StringBuilder sb = new StringBuilder();
            foreach (byte bt in a)
                sb.Append(bt.ToString("x2"));
            foreach (byte bt in b)
                sb.Append(bt.ToString("x2"));
            foreach (byte bt in c)
                sb.Append(bt.ToString("x2"));
            token = sb.ToString();
        }

        public static Token NewToken()
        {
            Random rnd = new Random(DateTimeOffset.Now.Millisecond);
            int A = rnd.Next(int.MinValue, int.MaxValue);
            int B = rnd.Next(int.MinValue, int.MaxValue);
            int C = rnd.Next(int.MinValue, int.MaxValue);
            return new Token(A, B, C);
        }

        public override string ToString()
        {
            return !String.IsNullOrWhiteSpace(token) ? token : Empty;
        }
    }
}